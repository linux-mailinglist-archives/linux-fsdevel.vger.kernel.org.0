Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76662201F8B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 03:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbgFTBuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 21:50:04 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:34155 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731502AbgFTBuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:50:04 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 98068D7A101;
        Sat, 20 Jun 2020 11:49:58 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jmSdp-0001zq-Bd; Sat, 20 Jun 2020 11:49:57 +1000
Date:   Sat, 20 Jun 2020 11:49:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>, jlayton@redhat.com
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200620014957.GQ2005@dread.disaster.area>
References: <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
 <20200618030539.GH2005@dread.disaster.area>
 <20200618034535.h5ho7pd4eilpbj3f@gabell>
 <20200618223948.GI2005@dread.disaster.area>
 <20200619022005.GA25414@fieldses.org>
 <20200619024455.GN2005@dread.disaster.area>
 <20200619204033.GB1564@fieldses.org>
 <20200619221044.GO2005@dread.disaster.area>
 <20200619222843.GB2650@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619222843.GB2650@fieldses.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=ZXktvxCZMkqgGL9u1qUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 06:28:43PM -0400, J. Bruce Fields wrote:
> On Sat, Jun 20, 2020 at 08:10:44AM +1000, Dave Chinner wrote:
> > On Fri, Jun 19, 2020 at 04:40:33PM -0400, J. Bruce Fields wrote:
> > > On Fri, Jun 19, 2020 at 12:44:55PM +1000, Dave Chinner wrote:
> > > > On Thu, Jun 18, 2020 at 10:20:05PM -0400, J. Bruce Fields wrote:
> > > > > My memory was that after Jeff Layton's i_version patches, there wasn't
> > > > > really a significant performance hit any more, so the ability to turn it
> > > > > off is no longer useful.
> > > > 
> > > > Yes, I completely agree with you here. However, with some
> > > > filesystems allowing it to be turned off, we can't just wave our
> > > > hands and force enable the option. Those filesystems - if the
> > > > maintainers chose to always enable iversion - will have to go
> > > > through a mount option deprecation period before permanently
> > > > enabling it.
> > > 
> > > I don't understand why.
> > > 
> > > The filesystem can continue to let people set iversion or noiversion as
> > > they like, while under the covers behaving as if iversion is always set.
> > > I can't see how that would break any application.  (Or even how an
> > > application would be able to detect that the filesystem was doing this.)
> > 
> > It doesn't break functionality, but it affects performance.
> 
> I thought you just agreed above that any performance hit was not
> "significant".

Yes, but that's just /my opinion/.

However, other people have different opinions on this matter (and we
know that from the people who considered XFS v4 -> v5 going slower
because iversion a major regression), and so we must acknowledge
those opinions even if we don't agree with them.

That is, if people are using noiversion for performance reasons on
filesystems that are not designed/intended to have it permanently
enabled, then yanking that functionality out from under them without
warning is a Bad Thing To Do.

If we want to change this behaviour, the mount option needs to be
deprecated and a date/kernel release placed on when it will no
longer function (at least a year in the future).  When the mount
option is used, it needs to log a deprecation warning to the syslog
so that users are informed that the option is going away. Then when
the deprecation date passes, the mount option can then be ignored by
the kernel.

> > IOWs, it can make certain workloads go a lot slower in some
> > circumstances.  And that can result in unexectedly breaking SLAs or
> > slow down a complex, finely tuned data center wide workload to the
> > point it no longer meets requirements.  Such changes in behaviour are
> > considered a regression, especially if they result from a change that
> > just ignores the mount option that turned off that specific feature.
> 
> I get that, but, what's the threshhold here for a significant risk of
> regression?

<shrug>

I have no real idea because the filesystems that are affected are
not ones I'm actively involved in supporting or developing for.
That's for the people with domain specific expertise - the
individual filesystem maintainers - to decide.

> The "noiversion" behavior is kinda painful for NFS.

Sure, but that's all you ever get on XFS v4 filesystems and any
other filesystem that doesn't support persistent iversion storage.
So the NFS implemenations are going to have to live with filesystems
without iversion support at all for many more years to come.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
