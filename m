Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114182CCBDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 02:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgLCBuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 20:50:51 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43118 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbgLCBuv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:50:51 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id EF6ED58BC6C;
        Thu,  3 Dec 2020 12:50:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kkdkx-00HUoo-T7; Thu, 03 Dec 2020 12:50:03 +1100
Date:   Thu, 3 Dec 2020 12:50:03 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH V2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Message-ID: <20201203015003.GN2842436@dread.disaster.area>
References: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
 <20201202160049.GD1447340@iweiny-DESK2.sc.intel.com>
 <CAJfpegt6w4h28VLctpaH46r2pkbcUNJ4pUhwUqZ-zbrOrXPEEQ@mail.gmail.com>
 <641397.1606926232@warthog.procyon.org.uk>
 <CAJfpegsQxi+_ttNshHu5MP+uLn3px9+nZRoTLTxh9-xwU8s1yg@mail.gmail.com>
 <X8flmVAwl0158872@kroah.com>
 <20201202204045.GM2842436@dread.disaster.area>
 <X8gBUc0fkdh6KK01@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8gBUc0fkdh6KK01@kroah.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=o35mPQnByGLdvpFsgc0A:9 a=CjuIK1q_8ugA:10
        a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:04:17PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 03, 2020 at 07:40:45AM +1100, Dave Chinner wrote:
> > On Wed, Dec 02, 2020 at 08:06:01PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Dec 02, 2020 at 06:41:43PM +0100, Miklos Szeredi wrote:
> > > > On Wed, Dec 2, 2020 at 5:24 PM David Howells <dhowells@redhat.com> wrote:
> > > > >
> > > > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > > Stable cc also?
> > > > > >
> > > > > > Cc: <stable@vger.kernel.org> # 5.8
> > > > >
> > > > > That seems to be unnecessary, provided there's a Fixes: tag.
> > > > 
> > > > Is it?
> > > > 
> > > > Fixes: means it fixes a patch, Cc: stable means it needs to be
> > > > included in stable kernels.  The two are not necessarily the same.
> > > > 
> > > > Greg?
> > > 
> > > You are correct.  cc: stable, as is documented in
> > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > ensures that the patch will get merged into the stable tree.
> > > 
> > > Fixes: is independent of it.  It's great to have for stable patches so
> > > that I know how far back to backport patches.
> > > 
> > > We do scan all commits for Fixes: tags that do not have cc: stable, and
> > > try to pick them up when we can and have the time to do so.  But it's
> > > not guaranteed at all that this will happen.
> > > 
> > > I don't know why people keep getting confused about this, we don't
> > > document the "Fixes: means it goes to stable" anywhere...
> > 
> > Except that is exactly what happens, sometimes within a day of two
> > of a patch with a Fixes tag hitting Linus' kernel. We have had a
> > serious XFS regression in the 5.9.9 stable kernel that should never
> > have happened as a result of exactly this "Fixes = automatically
> > swept immediately into stable kernels" behaviour. See here for
> > post-mortem analysis:
> > 
> > https://lore.kernel.org/linux-xfs/20201126071323.GF2842436@dread.disaster.area/T/#m26e14ebd28ad306025f4ebf37e2aae9a304345a5
> > 
> > This happened because these auotmated Fixes scans seem to occur
> > weekly during -rcX release periods, which means there really is *no
> > practical difference* between the way the stable process treats
> > Fixes tags and cc: stable.
> 
> Sometimes, yes, that is true.  But as it went into Linus's tree at the
> same time, we just ended up with "bug compatible" trees :)
> 
> Not a big deal overall, happens every few releases, we fix it up and
> move on.  The benifits in doing all of this _FAR_ outweigh the very
> infrequent times that kernel developers get something wrong.

I'm not debating that users benefit from backports. I'm talking
about managing risk profiles and how to prevent an entirely
preventable stable kernel regression from happening again.

Talking about risk profiles, the issue here is that the regression
that slipped through to the stable kernels had a -catastrophic- risk
profile. That's exactly the sort of things that the stable kernel is
supposed to avoid exposing users to, and that raises the importance
and priority of ensuring that *never happens again*.

And the cause of this regression slipping through to stable kernel
users? It was a result of the automated "fixes" scan done by the
stable process that results in "fixes" meaning the same thing as
"cc: stable"....

> As always, if you do NOT want your subsystem to have fixes: tags picked
> up automatically by us for stable trees, just email us and let us know
> to not do that and we gladly will.

No, that is not an acceptible solution for anyone. The stable
maintainers need to stop suggesting this as a solution to any
criticism that is raised against the stable process. You may as well
just say "shut up, go away, we don't care what you want".

> > It seems like this can all be avoided simply by scheduling the
> > automated fixes scans once the upstream kernel is released, not
> > while it is still being stabilised by -rc releases. That way stable
> > kernels get better tested fixes, they still get the same quantity of
> > fixes, and upstream developers have some margin to detect and
> > correct regressions in fixes before they get propagated to users.
> 
> So the "magic" -final release from Linus would cause this to happen?
> That means that the world would go for 3 months without some known fixes
> being applied to the tree?  That's not acceptable to me, as I started
> doing this because it was needed to be done, not just because I wanted
> to do more work...

I'm not suggesting that all fixes across the entire kernel get held
until release. That's just taking things to extremes for no valid
reason as the risk profiles of most subsystems don't justify needing
a margin of error that large. I'm asking that specific subsystems
with catastrophic failure risk profiles be allowed to opt
out of the "just merged" fixes scans and instead have them replaced
by a less frequent scan.

Perhaps we don't even need to wait for the full release. Maybe just
increasing the fixes scanning window for those subsystems to pick up
changes in -rc(X-2) so that the commits have been exposed to testing
for a couple of weeks before being considered a stable backport
candidate. 

That mitigates the immediate risk concern as it gives developers
time to catch and fix regressions before stable backports are done.
Such a 2 week delay would have avoided exposing stable kernel users
to dangerous regression that should never have been released outside
developer and test machines exercising the upstream -rcX tree.

> > It also creates a clear demarcation between fixes and cc: stable for
> > maintainers and developers: only patches with a cc: stable will be
> > backported immediately to stable. Developers know what patches need
> > urgent backports and, unlike developers, the automated fixes scan
> > does not have the subject matter expertise or background to make
> > that judgement....
> 
> Some subsystems do not have such clear demarcation at all. Heck, some
> subsystems don't even add a cc: stable to known major fixes.  And that's
> ok, the goal of the stable kernel work is to NOT impose additional work
> on developers or maintainers if they don't want to do that work.

Engineering is as much about improving processes as it is about
improving the thing that is being built.  I'm not asking you to stop
backporting fixes or stop improving the stable kernels. All I'm
asking for is to increase the latency of backports for some
subsystems because a margin of error is needed to minimise the risk
profile stable users are exposed to. IOWs, I'm asking for a *minor
tweak* to the existing process, not asking you to start all over
again.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
