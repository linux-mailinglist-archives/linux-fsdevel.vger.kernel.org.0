Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAB84AA9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 13:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbfHGLaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 07:30:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfHGLaM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:30:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C30A28D5E1;
        Wed,  7 Aug 2019 11:30:11 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4133C19C5B;
        Wed,  7 Aug 2019 11:30:11 +0000 (UTC)
Date:   Wed, 7 Aug 2019 07:30:09 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/24] xfs: reduce kswapd blocking on inode locking.
Message-ID: <20190807113009.GC19707@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-19-david@fromorbit.com>
 <20190806182213.GF2979@bfoster>
 <20190806213353.GJ7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806213353.GJ7777@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 07 Aug 2019 11:30:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 07, 2019 at 07:33:53AM +1000, Dave Chinner wrote:
> On Tue, Aug 06, 2019 at 02:22:13PM -0400, Brian Foster wrote:
> > On Thu, Aug 01, 2019 at 12:17:46PM +1000, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > When doing async node reclaiming, we grab a batch of inodes that we
> > > are likely able to reclaim and ignore those that are already
> > > flushing. However, when we actually go to reclaim them, the first
> > > thing we do is lock the inode. If we are racing with something
> > > else reclaiming the inode or flushing it because it is dirty,
> > > we block on the inode lock. Hence we can still block kswapd here.
> > > 
> > > Further, if we flush an inode, we also cluster all the other dirty
> > > inodes in that cluster into the same IO, flush locking them all.
> > > However, if the workload is operating on sequential inodes (e.g.
> > > created by a tarball extraction) most of these inodes will be
> > > sequntial in the cache and so in the same batch
> > > we've already grabbed for reclaim scanning.
> > > 
> > > As a result, it is common for all the inodes in the batch to be
> > > dirty and it is common for the first inode flushed to also flush all
> > > the inodes in the reclaim batch. In which case, they are now all
> > > going to be flush locked and we do not want to block on them.
> > > 
> > 
> > Hmm... I think I'm missing something with this description. For dirty
> > inodes that are flushed in a cluster via reclaim as described, aren't we
> > already blocking on all of the flush locks by virtue of the synchronous
> > I/O associated with the flush of the first dirty inode in that
> > particular cluster?
> 
> Currently we end up issuing IO and waiting for it, so by the time we
> get to the next inode in the cluster, it's already been cleaned and
> unlocked.
> 

Right..

> However, as we go to non-blocking scanning, if we hit one
> flush-locked inode in a batch, it's entirely likely that the rest of
> the inodes in the batch are also flush locked, and so we should
> always try to skip over them in non-blocking reclaim.
> 

This makes more sense. Note that the description is confusing because it
assumes context that doesn't exist in the code as of yet (i.e., no
mention of the nonblocking mode) and so isn't clear to the reader. If
the purpose is preparation for a future change, please note that clearly
in the commit log.

Second (and not necessarily caused by this patch), the ireclaim flag
semantics are kind of a mess. As you've already noted, we currently
block on some locks even with SYNC_TRYLOCK, yet the cluster flushing
code has no concept of these flags (so we always trylock, never wait on
unpin, for some reason use the shared ilock vs. the exclusive ilock,
etc.). Further, with this patch TRYLOCK|WAIT basically means that if we
happen to get the lock, we flush and wait on I/O so we can free the
inode(s), but if somebody else has flushed the inode (we don't get the
flush lock) we decide not to wait on the I/O that might (or might not)
already be in progress. I find that a bit inconsistent. It also makes me
slightly concerned that we're (ab)using flag semantics for a bug fix
(waiting on inodes we've just flushed from the same task), but it looks
like this is all going to change quite a bit still so I'm not going to
worry too much about this mostly existing mess until I grok the bigger
picture changes... :P

Brian

> This is really just a stepping stone in the logic to the way the
> LRU isolation function works - it's entirely non-blocking and full
> of lock order inversions, so everything has to run under try-lock
> semantics. This is essentially starting that restructuring, based on
> the observation that sequential inodes are flushed in batches...
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
