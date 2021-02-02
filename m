Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476C530CD55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 21:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhBBUwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 15:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231894AbhBBUwi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:52:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 292BB64E38;
        Tue,  2 Feb 2021 20:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612299117;
        bh=tuhcxZEWP8wGfxb4IWVCAu51pk1hGfeyf/0mzO4am/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkgIJgFSw5wOlPTyd8+7CjE9OrQGsL24d+QWMW3mtBzVcJ4+PxXUESgaIUx+L8YvN
         zEeC8x0OUqQYnQzSPK7FGEYt98EytaEQ3qpfQ8QBZwuAre2xiX0GOtsjw1TiuzD0o1
         njaYWV4LjwrFMl81uNG8izot0rk3e6zjppmf+WJZlNIhAJu+m5nphl5FhywRfazUS+
         AwCOkE1np/soDqIP/n3D4xNNFsEpF3K7BCLPycQV4KyGr3C8kUfzhjO7HK2IPOqZk7
         oX+KcbAwbKZrof7hTc21bTwNbWJ67qyBghzQ5ztLhQZA/JUFP+cexQWStnE+/YSetO
         uq4CX6QajEJHg==
Date:   Tue, 2 Feb 2021 12:51:56 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/16] xfs: drop ->writepage completely
Message-ID: <20210202205156.GU7193@magnolia>
References: <20181107063127.3902-1-david@fromorbit.com>
 <20181107063127.3902-2-david@fromorbit.com>
 <20181109151239.GD9153@infradead.org>
 <20181112210839.GM19305@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112210839.GM19305@dastard>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 13, 2018 at 08:08:39AM +1100, Dave Chinner wrote:
> On Fri, Nov 09, 2018 at 07:12:39AM -0800, Christoph Hellwig wrote:
> > [adding linux-mm to the CC list]
> > 
> > On Wed, Nov 07, 2018 at 05:31:12PM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > ->writepage is only used in one place - single page writeback from
> > > memory reclaim. We only allow such writeback from kswapd, not from
> > > direct memory reclaim, and so it is rarely used. When it comes from
> > > kswapd, it is effectively random dirty page shoot-down, which is
> > > horrible for IO patterns. We will already have background writeback
> > > trying to clean all the dirty pages in memory as efficiently as
> > > possible, so having kswapd interrupt our well formed IO stream only
> > > slows things down. So get rid of xfs_vm_writepage() completely.
> > 
> > Interesting.  IFF we can pull this off it would simplify a lot of
> > things, so I'm generally in favor of it.
> 
> Over the past few days of hammeringon this, the only thing I've
> noticed is that page reclaim hangs up less, but it's also putting a
> bit more pressure on the shrinkers. Filesystem intensive workloads
> that drive the machine into reclaim via the page cache seem to hit
> breakdown conditions slightly earlier and the impact is that the
> shrinkers are run harder. Mostly I see this as the XFS buffer cache
> having a much harder time keeping a working set active.
> 
> However, while the workloads hit the working set cache, writeback
> performance does seem to be slightly higher. It is, however, being
> offset by the deeper lows that come from the cache being turned
> over.
> 
> So there's a bit of rebalancing to be done here as a followup, but
> I've been unable to drive the system into unexepected OOM kills or
> other bad behaviour as a result of removing ->writepage.

FWIW I've been running this patch in my development kernels as part of
exercising realtime reflink with rextsize > 1.  So far I haven't seen
any particularly adverse effects.

--D

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
