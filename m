Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BE385667
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 01:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfHGXR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 19:17:57 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:50112 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729934AbfHGXR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:17:56 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 19A37361CB0;
        Thu,  8 Aug 2019 09:17:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hvVAl-0006Iz-1P; Thu, 08 Aug 2019 09:16:47 +1000
Date:   Thu, 8 Aug 2019 09:16:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/24] xfs: reduce kswapd blocking on inode locking.
Message-ID: <20190807231647.GS7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-19-david@fromorbit.com>
 <20190806182213.GF2979@bfoster>
 <20190806213353.GJ7777@dread.disaster.area>
 <20190807113009.GC19707@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807113009.GC19707@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=LIETh8aiTdfSQb0hYlUA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 07, 2019 at 07:30:09AM -0400, Brian Foster wrote:
> Second (and not necessarily caused by this patch), the ireclaim flag
> semantics are kind of a mess. As you've already noted, we currently
> block on some locks even with SYNC_TRYLOCK, yet the cluster flushing
> code has no concept of these flags (so we always trylock, never wait on
> unpin, for some reason use the shared ilock vs. the exclusive ilock,
> etc.). Further, with this patch TRYLOCK|WAIT basically means that if we
> happen to get the lock, we flush and wait on I/O so we can free the
> inode(s), but if somebody else has flushed the inode (we don't get the
> flush lock) we decide not to wait on the I/O that might (or might not)
> already be in progress. I find that a bit inconsistent. It also makes me
> slightly concerned that we're (ab)using flag semantics for a bug fix
> (waiting on inodes we've just flushed from the same task), but it looks
> like this is all going to change quite a bit still so I'm not going to
> worry too much about this mostly existing mess until I grok the bigger
> picture changes... :P

Yes, SYNC_TRYLOCK/SYNC_WAIT semantics are a mess, but they all go
away later in the patchset.  Non-blocking reclaim makes SYNC_TRYLOCK
go away because everything becomes try-lock based, and SYNC_WAIT goes
away because only the xfs_reclaim_inodes() function needs to wait
for reclaim completion and so that gets it's own LRU walker
implementation and the mode parameter is removed.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
