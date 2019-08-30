Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D9DA3FFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 23:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfH3VyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 17:54:18 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41751 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728111AbfH3VyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:54:17 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1E94A43D08B;
        Sat, 31 Aug 2019 07:54:12 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i3oqQ-0001cH-9d; Sat, 31 Aug 2019 07:54:10 +1000
Date:   Sat, 31 Aug 2019 07:54:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>, devel@driverdev.osuosl.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190830215410.GD7777@dread.disaster.area>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
 <20190829063955.GA30193@kroah.com>
 <20190829094136.GA28643@infradead.org>
 <20190829095019.GA13557@kroah.com>
 <20190829103749.GA13661@infradead.org>
 <20190829111810.GA23393@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829111810.GA23393@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=nsflCM8SZg1gMuGxmi4A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 01:18:10PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 29, 2019 at 03:37:49AM -0700, Christoph Hellwig wrote:
> > On Thu, Aug 29, 2019 at 11:50:19AM +0200, Greg Kroah-Hartman wrote:
> > > I know the code is horrible, but I will gladly take horrible code into
> > > staging.  If it bothers you, just please ignore it.  That's what staging
> > > is there for :)
> > 
> > And then after a while you decide it's been long enough and force move
> > it out of staging like the POS erofs code?
> 
> Hey, that's not nice, erofs isn't a POS.  It could always use more
> review, which the developers asked for numerous times.
> 
> There's nothing different from a filesystem compared to a driver.  If
> its stand-alone, and touches nothing else, all issues with it are
> self-contained and do not bother anyone else in the kernel.  We merge

I whole-heartedly disagree with that statement.

The major difference between filesystems and the rest of the kernel
that seems to be missed by most kernel developers is that
filesystems maintain persistent data - you can't fix a problem/bug
by rebooting or power cycling. Once the filesystem code screws up,
the user is left with a mess they have to fix and that invariably
results in data loss.

Users remember when a filesystem eats their data - they don't tend
to want to have anything to do with that filesystem ever again if it
happens to them. We still get people saying "XFS ate my data back in
2002, I dont trust it and I'll never use it again".

Users put up with shit hardware and drivers - it's an inconvenience
more than anything. They don't put up with buggy filesystems that
lose their data - that is completely unacceptible to users.  As a
result, the quality and stability standard for merging a new
filesystem needs to be far higher that what is acceptible for
merging a new driver.

The correct place for new filesystem review is where all the
experienced filesystem developers hang out - that's linux-fsdevel,
not the driver staging tree.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
