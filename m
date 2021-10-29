Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76164400CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 18:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhJ2RAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 13:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhJ2RAR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:00:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DE0060F93;
        Fri, 29 Oct 2021 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635526668;
        bh=1EkYpN95Sat5QcfuVfYPKyLQbRZMhX6FQT/4t7eB980=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvPd//JGVSi69c/RVQGqbBGRDOHUq6r63pqXs/Tw6+7iCfBh+bcqCI3YJ9no8otVa
         cdvCx6810Ag0oZ193Q9XSlB00nTFmTwhar6duSLb/dmJxAe6UBr7BJoDLq2xcsVnsJ
         3DlAjrb2m/YHmXPZ3VOTfs/zOAtK8tbe4HKLe3wIOGzBJOHVPmkbk7gq37uvu5Qge0
         Z2bSe2v9xkbkboHJsECOa9ufOhRuaQmeMoB17fxkGe+HBHV4m+FqMGx49MRsm5SsAB
         DEcGOQDksZLurNKovrFBGPLRrg1DlyFpvoBx/CaUXg4CbeQvGsiCYMoIXOhqEsLM3E
         6eCQQi1Xlok0w==
Date:   Fri, 29 Oct 2021 09:57:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <20211029165747.GC2237511@magnolia>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia>
 <20211028225955.GA449541@dread.disaster.area>
 <22255117-52de-4b2d-822e-b4bc50bbc52b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22255117-52de-4b2d-822e-b4bc50bbc52b@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 12:46:14PM +0100, Pavel Begunkov wrote:
> On 10/28/21 23:59, Dave Chinner wrote:
> [...]
> > > > Well, my point is doing recovery from bit errors is by definition not
> > > > the fast path.  Which is why I'd rather keep it away from the pmem
> > > > read/write fast path, which also happens to be the (much more important)
> > > > non-pmem read/write path.
> > > 
> > > The trouble is, we really /do/ want to be able to (re)write the failed
> > > area, and we probably want to try to read whatever we can.  Those are
> > > reads and writes, not {pre,f}allocation activities.  This is where Dave
> > > and I arrived at a month ago.
> > > 
> > > Unless you'd be ok with a second IO path for recovery where we're
> > > allowed to be slow?  That would probably have the same user interface
> > > flag, just a different path into the pmem driver.
> > 
> > I just don't see how 4 single line branches to propage RWF_RECOVERY
> > down to the hardware is in any way an imposition on the fast path.
> > It's no different for passing RWF_HIPRI down to the hardware *in the
> > fast path* so that the IO runs the hardware in polling mode because
> > it's faster for some hardware.
> 
> Not particularly about this flag, but it is expensive. Surely looks
> cheap when it's just one feature, but there are dozens of them with
> limited applicability, default config kernels are already sluggish
> when it comes to really fast devices and it's not getting better.
> Also, pretty often every of them will add a bunch of extra checks
> to fix something of whatever it would be.

So we can't have data recovery because moving fast the only goal?

That's so meta.

--D

> So let's add a bit of pragmatism to the picture, if there is just one
> user of a feature but it adds overhead for millions of machines that
> won't ever use it, it's expensive.
> 
> This one doesn't spill yet into paths I care about, but in general
> it'd be great if we start thinking more about such stuff instead of
> throwing yet another if into the path, e.g. by shifting the overhead
> from linear to a constant for cases that don't use it, for instance
> with callbacks or bit masks.
> 
> > IOWs, saying that we shouldn't implement RWF_RECOVERY because it
> > adds a handful of branches 	 the fast path is like saying that we
> > shouldn't implement RWF_HIPRI because it slows down the fast path
> > for non-polled IO....
> > 
> > Just factor the actual recovery operations out into a separate
> > function like:
> 
> -- 
> Pavel Begunkov
